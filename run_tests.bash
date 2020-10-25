suite()
{
  . ./__specs/utils/printer_specs.bash
  . ./__specs/utils/modes_specs.bash
  . ./__specs/utils/fs.specs.bash
  . ./__specs/scan/scan_photo_specs.bash
  . ./__specs/input/get_presets_specs.bash
}

# Load testing framework
. ./bin/shunit2

