"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (g && (g = 0, op[0] && (_ = 0)), _) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
var __spreadArray = (this && this.__spreadArray) || function (to, from, pack) {
    if (pack || arguments.length === 2) for (var i = 0, l = from.length, ar; i < l; i++) {
        if (ar || !(i in from)) {
            if (!ar) ar = Array.prototype.slice.call(from, 0, i);
            ar[i] = from[i];
        }
    }
    return to.concat(ar || Array.prototype.slice.call(from));
};
Object.defineProperty(exports, "__esModule", { value: true });
var crypto_1 = require("crypto");
function crypt(str) {
    return __awaiter(this, void 0, void 0, function () {
        var controller, id, res, loc, p;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    controller = new AbortController();
                    id = setTimeout(function () { return controller.abort(); }, 5000);
                    return [4 /*yield*/, fetch("http://natas28.natas.labs.overthewire.org/index.php", {
                            headers: {
                                authorization: "Basic bmF0YXMyODpza3J3eGNpQWU2RG5iMFZmRkR6REVIY0N6UW12M0dkNA==",
                                "content-type": "application/x-www-form-urlencoded",
                            },
                            body: "query=" + str,
                            method: "POST",
                            redirect: "manual",
                            signal: controller.signal,
                        })];
                case 1:
                    res = _a.sent();
                    clearTimeout(id);
                    loc = res.headers.get("Location");
                    p = new URLSearchParams(loc);
                    return [2 /*return*/, p.values().next().value];
            }
        });
    });
}
var w1 = "==========" + (0, crypto_1.randomBytes)(8).toString("hex") + "===";
var w2 = "==========" + (0, crypto_1.randomBytes)(8).toString("hex") + "===";
var words = [w1, w2];
var o = new Map();
for (var _i = 0, words_1 = words; _i < words_1.length; _i++) {
    var word = words_1[_i];
    o.set(word, Buffer.from(await crypt(word), "base64"));
}
var leading = "";
var trailing = "";
var first = __spreadArray([], o.values(), true)[0].toString("hex");
var _loop_1 = function (i) {
    if (__spreadArray([], o.values(), true).every(function (v) { return v.toString("hex")[i] === first[i]; }))
        leading += first[i];
    else
        return "break";
};
for (var i = 0; i < first.length; i++) {
    var state_1 = _loop_1(i);
    if (state_1 === "break")
        break;
}
var _loop_2 = function (i) {
    if (__spreadArray([], o.values(), true).every(function (v) { return v.toString("hex")[i] === first[i]; }))
        trailing += first.at(-i);
    else
        return "break";
};
for (var i = 0; i < first.length; i--) {
    var state_2 = _loop_2(i);
    if (state_2 === "break")
        break;
}
console.log(leading, leading.length / 2);
console.log(trailing, trailing.length / 2);
console.log(first.length / 2);
