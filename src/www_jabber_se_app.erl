%
%    Jabber.se Web Application
%    Copyright (C) 2010 Jonas Ådahl
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU Affero General Public License as
%    published by the Free Software Foundation, either version 3 of the
%    License, or (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU Affero General Public License for more details.
%
%    You should have received a copy of the GNU Affero General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.
%

-module(www_jabber_se_app).
-export([
        start/0, start/2, stop/1, init/1,
        out/1, out/2, out/3
    ]).
-behaviour(application).
-behaviour(supervisor).

-include("include/config.hrl").
-include("include/utils.hrl").

-define(PORT, 8000).

start() ->
    try
        application:load(www_jabber_se),
        {ok, Applications} = application:get_key(www_jabber_se, applications),
        {Started, _, _} = lists:unzip3(application:which_applications()),
        [ok = application:start(A) || A <- Applications -- Started],
        ok = application:start(www_jabber_se)
    catch
        _:_ = Error ->
            error_logger:error_report(["Error when starting www_jabber_se",
                                       {error, Error},
                                       {stacktrace, erlang:get_stacktrace()}])
    end.

start(_, _) ->
    try
        case supervisor:start_link(?MODULE, []) of
            ignore    -> {error, ignore};
            {ok, Pid} -> {ok, Pid, Pid};
            Error     -> error_logger:error_report(["Error when starting supervisor",
                                                     {error, Error}])
        end
    catch
        _:_ = Exception ->
            error_logger:error_report(["Error when starting the application www_jabber_se",
                                       {exception, Exception},
                                       {stacktrace, erlang:get_stacktrace()}])
    end.

init(_Args) ->
    {ok, {{one_for_one, 30, 60},
          [{Module, {Module, start, []},
            permanent, 2000, worker, [Module]}
           || Module <- ?MODULES]}}.

stop(Pid) ->
    exit(Pid, shutdown).

contents([Content | Contents]) ->
    case atom_to_list(Content) of
        "content_" ++ ContentS ->
            [ContentS | contents(Contents)];
        ContentS ->
            [ContentS | contents(Contents)]
    end;
contents([]) ->
    [].

out(Arg) ->
    RequestBridge = simple_bridge:make_request(yaws_request_bridge, Arg),
    ResponseBridge = simple_bridge:make_response(yaws_response_bridge, Arg),
    nitrogen:init_request(RequestBridge, ResponseBridge),
    Contents = cf_config:enabled_content(),

    nitrogen:handler(named_route_handler,
        % Content
        [{[$/ | Content], web_index}
         || Content <- [""|contents(Contents)]] ++

        [
            {"/feed", web_feed},

            % Static files
            {"/res", static_file},
            {"/nitrogen", static_file},
            {"/jabber.se", static_file}
        ]),

    % Set default content type (default in nitrogen is "text/html").
    wf:header("Content-Type", "text/html; charset=UTF-8"),

    % Run nitrogen
    nitrogen:run().

out(Arg, Module) -> out(Arg, Module, "").

out(Arg, Module, PathInfo) ->
    ?LOG_WARNING("Unhandled ~p ~p ~p", [Arg, Module, PathInfo]).

