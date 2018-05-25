for a in *.gsm 
do  
    echo $a
    /usr/bin/sox -c 1  -r 8000 "$a" -t wav -r 8000 -c 1 -b 16 ${a/.gsm/.wav/} 

 done
