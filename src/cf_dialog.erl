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

-module(cf_dialog).
-export([show/1, show/2]).

-include("include/ui.hrl").

-spec show(element_dialog:dialog()) -> any().
show(Dialog) ->
    show(Dialog, fun() -> ok end).

-spec show(element_dialog:dialog(), fun(() -> term())) -> any().
show(Dialog, ContentFun) ->
    Id = Dialog#dialog.id,
    Class = Dialog#dialog.class,
    wf:update(dialogs, Dialog#dialog{class = lists:flatten([top_dialog, Class])}),
    ContentFun(),
    wf:wire(Id, #dialog_show{}).

