%
%    Jabber.se Web Application
%    Copyright (C) 2010-2011 Jonas Ådahl
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

-module(content_news).

-export([body/1, atom/1, atom_url/0]).

-include("include/utils.hrl").
-include("include/content.hrl").

-define(CMS_VIEW, "news").

body(_) ->
    Title = ?TXT("News"),
    #content{body = cms:body(Title, ?CMS_VIEW),
             title = Title}.

atom(URL) ->
    cms:atom(URL, ?TXT("News"), ?CMS_VIEW).

atom_url() ->
    {ok, web_feed:get_url(?MODULE)}.

