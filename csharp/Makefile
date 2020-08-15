zerochecker.dll: Main.cs
	dotnet build --configuration Release
	cp bin/Release/netcoreapp3.1/zerocheck.dll zerochecker.dll
	cp bin/Release/netcoreapp3.1/zerocheck.runtimeconfig.json zerochecker.runtimeconfig.json

clean:
	-rm zerochecker.dll
	-rm zerochecker.runtimeconfig.json
	
.PHONY: clean
