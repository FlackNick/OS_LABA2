#! /usr/bin/env bash
function funs(){
    echo "ProcessID = 235 : Parent_ProcessID = 234 : Avegage_Time = 456"
}
as=$(bc <<< "scale=1;8646893.8649324 + 65325795.2345667")
echo $as