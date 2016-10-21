#!/usr/bin/env bats

@test "check SELinux enforcing" {
    [ "$(getenforce)" = "Enforcing" ]
}

@test "check XSM enforcing" {
    [ "$(xenops getenforce)" = "Enforcing" ]
}

@test "no kernel classes/permissions left undefined in the SELinux policy" {
    count=$(grep SELinux.*not defined /var/log/messages|wc -l)

    [ "${count}" -eq 0 ]
}

@test "check NDVM flask label" {
    run xec-vm -n Network -g flask-label

    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "system_u:system_r:ndvm_t" ]
}

@test "check UIVM flask label" {
    run xec-vm -n uivm -g flask-label

    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "system_u:system_r:uivm_t" ]
}

@test "check SyncVM flask label" {
    run xec-vm -n syncvm -g flask-label

    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "system_u:system_r:syncvm_t" ]
}
