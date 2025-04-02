#!/usr/bin/env bash
devcontainer features test -f . \
    --base-image mcr.microsoft.com/devcontainers/python:3.11-bullseye
