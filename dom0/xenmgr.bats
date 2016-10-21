#!/usr/bin/env bats

@test "test VM creation/destroy" {
  # Make sure the new-vm template is available
  run xec -i com.citrix.xenclient.xenmgr list-templates
  [ ${status} -eq 0 ]
  grep -q "new-vm" <<< ${output}

  # Create a new vm using the new-vm template
  run xec -i com.citrix.xenclient.xenmgr create-vm-with-template new-vm
  [ ${status} -eq 0 ]
  vm=${lines[0]}

  # Verify the vm was created
  run xec -i com.citrix.xenclient.xenmgr list-vms
  [ ${status} -eq 0 ]
  grep -q ${vm} <<< ${output}

  # Delete the vm
  run xec -i com.citrix.xenclient.xenmgr.vm -o ${vm} delete
  [ ${status} -eq 0 ]

  # Verify the vm is gone
  run xec -i com.citrix.xenclient.xenmgr list-vms
  [ ${status} -eq 0 ]
  ! grep -q ${vm} <<< ${output}
}

@test "test VHD creation" {
  run xec -i com.citrix.xenclient.xenmgr create_vhd 10
  [ ${status} -eq 0 ]

  [ -e ${lines[0]} ]

  run rm -f ${lines[0]}
  [ ${status} -eq 0 ]
}
