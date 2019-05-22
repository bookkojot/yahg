while(<>){
if(/^\S+\s+([^ \t\r\n#]+)/){print "127.0.0.1\t$1\r\n";}
}

