# IaaC for `app-rest`

## Usage

* `command/validate.sh AMI_CONFIG_PATH` - validate Packer configuration located under `AMI_CONFIG_PATH`
  * i.e. `command/validate.sh infrastructure/ami.json`
* `command/build.sh AMI_CONFIG_PATH` - Build AMI using configuration located under `AMI_CONFIG_PATH`
  * i.e. `command/build.sh infrastructure/ami.json`

## Utils
  
* `command//utils/session-start.sh MODULE ENV LOG_NAME` - Utility :: Starts command/ution recording
* `command//utils/session-stop.sh` - Utility :: Stops command/ution recording

## Documentation
* [Packer](https://www.packer.io/docs/index.html)
