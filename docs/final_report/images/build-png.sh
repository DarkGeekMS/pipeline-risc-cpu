for i in *.drawio; do 
    F=$(echo $i | awk 'BEGIN{FS="."}; {print $1}')
    echo start $F.drawio
    drawio $F.drawio -x -f png -o $F.png -b 1 &
done
