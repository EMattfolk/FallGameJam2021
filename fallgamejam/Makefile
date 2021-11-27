.PHONY: run sylt

run: | sylt
	../target/debug/sylt -c main.lua main.sy
	love .

sylt:
	cd .. && cargo b

