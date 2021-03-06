%%<copyright>
%% <year>2006-2007</year>
%% <holder>Ericsson AB, All Rights Reserved</holder>
%%</copyright>
%%<legalnotice>
%% The contents of this file are subject to the Erlang Public License,
%% Version 1.1, (the "License"); you may not use this file except in
%% compliance with the License. You should have received a copy of the
%% Erlang Public License along with this software. If not, it can be
%% retrieved online at http://www.erlang.org/.
%%
%% Software distributed under the License is distributed on an "AS IS"
%% basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
%% the License for the specific language governing rights and limitations
%% under the License.
%%
%% The Initial Developer of the Original Code is Ericsson AB.
%%</legalnotice>
%%

-ifndef(snmpm_internal).
-define(snmpm_internal, true).

-include_lib("snmp/src/app/snmp_internal.hrl").

-define(snmpm_info(F, A),    ?snmp_info("manager",    F, A)).
-define(snmpm_warning(F, A), ?snmp_warning("manager", F, A)).
-define(snmpm_error(F, A),   ?snmp_error("manager",   F, A)).

-endif. % -ifdef(snmpm_internal).



