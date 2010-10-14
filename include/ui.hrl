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

-ifndef(ui_hrl).
-define(ui_hrl, true).

-include_lib("nitrogen/include/wf.hrl").

%
% Elements
%

-record(strong, {?ELEMENT_BASE(element_typeface), body = "", text = "", html_encode = true}).
-record(state_panel, {?ELEMENT_BASE(element_state_panel), bodies, inline = false, visible = false, init_state}).
-record(dialog, {?ELEMENT_BASE(element_dialog), corner = close, title = "", body = ""}).

-record(ext_link, {?ELEMENT_BASE(element_ext_link), url, type, rel, title}).

-record(pager, {?ELEMENT_BASE(element_pager), count = 1, init_page = 1, adapter}).

%
% Actions
%

-record(state_panel_set, {?ACTION_BASE(action_state_panel), key, animate = false, validate_group}).
-record(state_panel_show, {?ACTION_BASE(action_state_panel), key}).
-record(state_panel_hide, {?ACTION_BASE(action_state_panel)}).

-record(dyn_dialog_back, {?ACTION_BASE(action_dialog)}).
-record(dyn_dialog_set, {?ACTION_BASE(action_dialog), title, body}).
-record(dyn_dialog_corner, {?ACTION_BASE(action_dialog), corner}).

-record(dialog_show, {?ACTION_BASE(action_dialog)}).
-record(dialog_hide, {?ACTION_BASE(action_dialog)}).

-record(autocomplete, {?ACTION_BASE(action_autocomplete), method = enable, alternatives = []}).

-record(focus, {?ACTION_BASE(action_jquery_cast)}).
-record(select, {?ACTION_BASE(action_jquery_cast)}).
-record(jquery_cast, {?ACTION_BASE(action_jquery_cast), cast, arg}).

-record(disable, {?ACTION_BASE(action_jquery_attr)}).
-record(enable, {?ACTION_BASE(action_jquery_attr)}).
-record(jquery_attr, {?ACTION_BASE(action_jquery_attr), key, value}).

-record(site_cast, {?ACTION_BASE(action_site), cast, args = []}).

-record(js_call, {?ACTION_BASE(action_js_call), fname, args = []}).

-record(pager_set, {?ACTION_BASE(action_pager), last, new, count, adapter}).

-record(update_table, {?ACTION_BASE(action_update_table), rows, effect}).

-endif.
