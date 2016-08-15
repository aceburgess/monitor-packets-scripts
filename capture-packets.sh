#! /bin/bash

read -p "What interface do yout want to capture packets on? " INTERFACE
echo -e "\nWe will capture on $INTERFACE \n"

PLEASE="Please answer yes or no \n"


# SET FILESIZE

read -p "Do you want to specify a filesize for the .pcap file? (-C) y/N " YN

case $YN in
  [Yy]*)
    read -p "What size in MB's please? " FILESIZE
    OPTIONSARR[0]="-C $FILESIZE"
  ;;
  [Nn]*)
    FILECOMMAND=" " && echo -e "Ok no filesize selected moving on .. \n"
  ;;
  *)
    echo -e $PLEASE
  ;;
esac


# SET PACKET LIMIT

read -p "Do you want to set a packet limit for the .pcap file? (-c) y/M " YN

case $YN in
  [Yy]*)
    read -p "How many packets to you want to limit this dump to? (-c) " PACKETCOUNT
    OPTIONSARR[1]="-c $PACKETCOUNT"
  ;;
  [Nn]*)
    echo -e "Ok all packets will be collected with no limit ... \n"
  ;;
  *)
    echo -e $PLEASE
  ;;
esac


# SET BUFFER LIMIT

read -p "Do you want to specify a buffer limit (File-Count) for the .pcap file? y/N (-W) " YN

case $YN in
  [Yy]*)
    read -p "What is the buffer limit you want to set? " BUFFERLIMIT
    OPTIONSARR[2]="-W $BUFFERLIMIT"
  ;;
  [Nn]*)
    echo -e "Ok no buffer limit set moving on ... \n"
  ;;
  *)
    echo -e $PLEASE
  ;;
esac


# SET FILENAME
read -p "Please give me a filename to use (I'll add the .pcap extension (-w) " FILENAME
FILENAME+=".pcap"


#RUN COMMAND
TCPDUMPCOMMAND="tcpdump -i $INTERFACE"

echo "This is the options array ${OPTIONSARR[@]} "

OPTIONS=" "

for OPTION in "${OPTIONSARR[@]}"; do
  echo "This is an option $OPTION"
  if [[ "$OPTION" == " " ]]; then
    continue
  fi
  OPTIONS+="$OPTION "
done

TCPDUMPCOMMAND+="$OPTIONS"
TCPDUMPCOMMAND+="-w $FILENAME"
clear
echo -e "\n\nRUNNING>> $TCPDUMPCOMMAND\n\n"


$TCPDUMPCOMMAND
