#!/usr/bin/env bash

printf "\n"
echo -e "
        \e[31mAA\e[0m             \e[31mcCC\e[0m   \e[31mMM\e[0m        \e[31mMM\e[0m   |
       \e[31maAAA\e[0m          \e[31mCCCCCC\e[0m \e[31mmMMM\e[0m      \e[31mMMM\e[0m   | Spring 2018 - SIG SysAdmin - \e[1msysadmin.acmapp\e[0m
       \e[31maAAA\e[0m         \e[31mCCCCCCc\e[0m \e[31mmMMMM\e[0m    \e[31mMMMM\e[0m   | For support, please contact an
       \e[31maAAAA\e[0m      \e[31mcCCCCc\e[0m    \e[31mmMMMMM\e[0m  \e[31mMMMMM\e[0m   | ACM SysAdmin at UIC.
     \e[31mAAAAAAAa\e[0m     \e[31mCCCC\e[0m      \e[31mmMMMMMMMMMMMM\e[0m   |
     \e[31mAAAAaAAA\e[0m    \e[31mcCCC\e[0m       \e[31mmMMmMMMMMMmMM\e[0m   | Hostname:\t \e[1m`hostname`.acmapp.tech\e[0m
     \e[31mAAA\e[0m  \e[31mAAAA\e[0m   \e[31mcCCC\e[0m       \e[31mmMMm\e[0m \e[31mMMMM\e[0m \e[31mmMM\e[0m   | IPv4:\t \e[1m`ip route get 8.8.8.8 2> /dev/null | awk '{print $(NF); exit}'`\e[0m
           \e[31mAAA\e[0m   \e[31mcCCC\e[0m       \e[31mmMMm\e[0m  \e[31mMM\e[0m  \e[31mmMM\e[0m   | IPv6:\t \e[1m`ip route get 2001:4860:4860::8888 2> /dev/null | awk '{for(i=1;i<=NF;i++) if ($i=="src") print $(i+1)}'`\e[0m
                                       \e[31mmM\e[0m   |
   \e[31mAAAAAAAAAAAaa\e[0m  \e[31mccc\e[0m       \e[31mmMMm\e[0m      \e[31mmMM\e[0m   | Note: IPv6 traffic is experimental and may
  \e[31mAAAAAAAAAAAAAA\e[0m  \e[31mCCCc\e[0m      \e[31mmMMm\e[0m      \e[31mmMM\e[0m   |       not work as intended.
  \e[31mAAA\e[0m        \e[31mAAAa\e[0m \e[31mcCCCc\e[0m     \e[31mmMMm\e[0m      \e[31mmMM\e[0m   |
 \e[31mAAAa\e[0m         \e[31mAAA\e[0m  \e[31mCCCCC\e[0m    \e[31mmMMm\e[0m      \e[31mmMM\e[0m   | Node: \e[1msysadmin.acmapp.tech\e[0m
\e[31mAAAA\e[0m          \e[31mAAAA\e[0m  \e[31mCCCCCCc\e[0m \e[31mmMMm\e[0m      \e[31mmMM\e[0m   |
 \e[31mAAa\e[0m           \e[31mAAA\e[0m   \e[31mcCCCCc\e[0m  \e[31mMM\e[0m        \e[31mMM\e[0m   | **Low-resource mode is ACTIVE!**
                \e[31maa\e[0m      \e[31mcc\e[0m"
printf "\n"
