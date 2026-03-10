#!/bin/bash
dotenv(){
 envfile=$1
 if [ ! -f $envfile ];
 then
     "$envfile file not exists!"
     exit 1
 fi
 set -a && source $envfile && set +a
}
