erl -sname master -setcookie 3ren -pa /core/ebin -pa /iconv -pa /modules/erlsoap/ebin -pa /modules/erlsom-1.2.1/ebin -pa /modules/iconv -pa /web/mochiweb -pa /web/ebin -pa /plugin/ebin -pa /modules/df_snmp/ebin -pa /modules/nmap_scan/ebin -pa /modules/df_snmp/ebin -pa /modules/snmp/ebin -pa /modules/esdl-1.0.1/ebin -pa /modules/erlcmdb/ebin -pa /modules/ssh/ebin -pa /core/utils/GsmOperateUtils -pa /modules/nnm/ebin -pa /nitrogen/ebin -pa /sec/ebin -boot start_sasl  -env ERL_MAX_ETS_TABLES 1000000 +P 10000000 -s ecc