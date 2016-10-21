#!/usr/bin/env bats

@test "read-only root file system" {
    grep "\sro[\s,]" /proc/mounts | grep -q xenclient-root
}

@test "check boot SELinux labels" {
    run restorecon -Rnv /boot
    count=$(echo ${output} | grep reset | wc -l)

    [ "$count" -eq 0 ]
}

@test "check config SELinux labels" {
    run restorecon -Rnv /boot
    count=$(echo ${output} | grep reset | wc -l)

    [ "$count" -eq 0 ]
}

@test "check storage SELinux labels" {
    run restorecon -Rnv /boot
    count=$(echo ${output} | grep reset | wc -l)

    [ "$count" -eq 0 ]
}
