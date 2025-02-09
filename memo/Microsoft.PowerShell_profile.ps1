function docker-containers {
    docker ps --format "{{.Names}}"
}

function dcu {
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$args
    )
    $composeFile = rg --files -g "*compose.*y*ml" -g "!*/" | fzf
    if ($composeFile) {
        echo $args
        docker compose -f $composeFile up $args
    }
}

function dcd {
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$args
    )
    $composeFile = rg --files -g "*compose.*y*ml" -g "!*/" | fzf
    if ($composeFile) {
        echo $args
        docker compose -f $composeFile down $args
    }
}

function de {
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$args
    )
    $container = docker-containers | fzf
    if ($container) {
        docker exec -it $container $args
    }
}
function da {
    $container = docker-containers | fzf
    if ($container) {
        docker attach $container
    }
}
function dk {
    $container = docker-containers | fzf
    if ($container) {
        docker kill $container
    }
}
function dl {
    $container = docker-containers | fzf
    if ($container) {
        docker logs $container
    }
}