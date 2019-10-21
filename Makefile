PROTO_ROOT_DIR = $(shell brew --prefix)/Cellar/protobuf/$(shell brew info protobuf --json | jq --raw-output ".[0].installed[0].version")/include
PROJECT_NAME = flutter-grpc-chat

_gendart:
	@mkdir -p protos/dart
	@protoc -I=protos --dart_out=grpc:protos/dart protos/*.proto
	@protoc -I$(PROTO_ROOT_DIR) --dart_out=protos/dart $(PROTO_ROOT_DIR)/google/protobuf/*.proto

_gengo:
	@mkdir -p protos/go
	@protoc -I=protos --go_out=plugins=grpc:protos/go protos/*.proto

gen: _gendart _gengo