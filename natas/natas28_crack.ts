async function crypt(str: string) {
	const controller = new AbortController();
	const id = setTimeout(() => controller.abort(), 5000);
	const res = await fetch(
		"http://natas28.natas.labs.overthewire.org/index.php",
		{
			headers: {
				authorization:
					"Basic bmF0YXMyODpza3J3eGNpQWU2RG5iMFZmRkR6REVIY0N6UW12M0dkNA==",
				"content-type": "application/x-www-form-urlencoded",
			},
			body: "query=" + encodeURIComponent(str),
			method: "POST",
			redirect: "manual",
			signal: controller.signal,
		}
	);
	clearTimeout(id);
	const loc = res.headers.get("Location");
	const p = new URLSearchParams(loc);
	const val = p.values().next().value;
	const buf = Buffer.from(val, "base64");
	const arr = [...buf];
	console.log(`crypt ${str.padEnd(26, "?")} -> ${hex(arr.slice(48, 48 + 16))}`);
	//	console.log(buf.slice(48, 48 + 16).toString("hex"));
	//	console.log(buf.slice(48 + 16, 48 + 16 + 16).toString("hex"));
	return arr;
}

let printableAscii = "";
for (let i = 32; i <= 126; i++) {
	printableAscii += String.fromCharCode(i);
}

const hex = (arr: Array<number>) =>
	arr.map((e) => e.toString(16).padStart(2, "0")).join("");

let str = "%";

const sampleResponse = await crypt("==========" + "X".repeat(15 - str.length));
const sampleBlock = hex(sampleResponse.slice(48, 48 + 16));
console.log("Looking for block " + sampleBlock);

for (const c of printableAscii) {
	const word = "==========" + "X".repeat(15 - str.length) + str + "\\" + c;
	const response = await crypt(word);
	const block = hex(response.slice(48, 48 + 16));
	if (block === sampleBlock) {
		console.log(JSON.stringify(c), "!");
		str += c;
		break;
	}
}
