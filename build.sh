#!/bin/bash

echo "---[ build ]-------------------------"
cd ${BASE}
echo "pwd = $(pwd)"

set -x
rm -rf ${WORKSPACE}/bin/*

#go get github.com/dgrijalva/jwt-go
#go get github.com/eclipse/paho.mqtt.golang
#go get github.com/go-playground/locales/en
#go get github.com/go-playground/universal-translator
#go get github.com/jackc/pgconn
#go get github.com/jackc/pgx
#go get github.com/jackc/pgx/stdlib
#go get github.com/lib/pq
#go get golang.org/x/crypto/bcrypt
#go get gopkg.in/go-playground/validator.v9
#go get gopkg.in/go-playground/validator.v9/translations/en

go install ./...
