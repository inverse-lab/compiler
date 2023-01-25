#!/bin/bash

echo Starting Compile Script . . .

function target(){
	. target.sh
}

function telegram(){
        . telegram.sh
} 

function check(){
	. check.sh
}

function compile(){
	. compile.sh
}

function exit(){
        . exit.sh
}

target
telegram
check
compile
exit
