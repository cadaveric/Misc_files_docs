#!/bin/bash
    ssh -o StrictHostKeyChecking=no -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa root@192.168.16.78 "/etc/obs/prepare_for_profile_sync.sh"
    [ "$?" -ne 0 ] && continue

   ssh -o StrictHostKeyChecking=no -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa root@192.168.16.78 "[ ! -e /home/SophosSetup_new.sh ]" && scp /home/ilkatsarov/Downloads/SophosSetup_new.sh root@192.168.16.78:/home/

