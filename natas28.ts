import { randomBytes } from "crypto";
import { exit } from "process";

async function crypt(str) {
	console.log("crypt", str);
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
			body: "query=" + str,
			method: "POST",
			redirect: "manual",
			signal: controller.signal,
		}
	);
	clearTimeout(id);
	const loc = res.headers.get("Location");
	const p = new URLSearchParams(loc);
	return p.values().next().value;
}

const w1 = "==========" + randomBytes(8).toString("hex") + "==";
const w2 = "==========" + randomBytes(16).toString("hex") + "==";

const words = [w1, w2];

const o = new Map<string, Buffer>();
for (const word of words) {
	o.set(word, Buffer.from(await crypt(word), "base64"));
}

let leading = [];
let trailing = [];
const first = [...o.values()][0];
const second = [...o.values()][1];
for (let i = 0; i < first.length; i++) {
	if ([...o.values()].every((v) => v[i] === first[i])) leading.push(first[i]);
	else break;
}
for (let i = 1; i <= first.length; i++) {
	if ([...o.values()].every((v) => v.at(-i) === first.at(-i)))
		trailing.push(first.at(-i));
	else break;
}

console.log(leading.length);
console.log(trailing.length);
console.log(first.length);
