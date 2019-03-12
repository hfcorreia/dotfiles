function dsh() {
    docker exec -it $1 bash
}

autoload dsh
