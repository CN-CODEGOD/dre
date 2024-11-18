const { exec } = require('node:child_process');
const path = require('node:path');
const os = require("os");
const { argv } = require('node:process');
const jsdom = require("jsdom");

const encoding = 'utf-8';  // 直接使用 UTF-8 编码

// 获取当前路径
const currentDir = process.cwd();

// 构建 PowerShell 脚本路径，并确保路径包含空格时被正确处理
const scriptPath = path.join(currentDir, 'crawl1.ps1');

// 获取命令行参数
const url = argv.slice(2)[0];  // 从命令行获取URL

if (!url) {
    console.error('请提供一个URL作为参数');
    process.exit(1);
}

// 异步执行 PowerShell 脚本
exec(`powershell -ExecutionPolicy Bypass -File "c:\\Program Files\\PowerShell\\7\\Modules\\dre\\crawl1.ps1" ${url}`, { encoding }, (error, stdout, stderr) => {
    if (error) {
        console.error('执行 PowerShell 脚本时出错:', error.message);
        return;
    }

    if (stderr) {
        console.error('PowerShell 错误输出:', stderr);
        return;
    }

    // 直接将返回的 HTML 内容传给 jsdom 解析
    try {
        const dom = new jsdom.JSDOM(stdout);
        console.log(dom.window.document.title);
    } catch (err) {
        console.error('解析网页时出错:', err);
    }       
});
