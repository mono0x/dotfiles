#!/bin/sh
go get -u \
    github.com/fatih/gomodifytags \
    github.com/fatih/motion \
    github.com/zmb3/gogetdoc \
    golang.org/x/lint/golint \
    golang.org/x/tools/cmd/gopls \
    golang.org/x/tools/cmd/gorename \
    golang.org/x/tools/cmd/guru \
    honnef.co/go/tools/cmd/... \
    mvdan.cc/gofumpt \
    mvdan.cc/gofumpt/gofumports
