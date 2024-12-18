const { exec } = require('node:child_process');
const path = require('node:path');
const os = require("os");
const iconv = require('iconv-lite');
const { JSDOM } = require('jsdom');

// 设置平台对应的编码
const encoding = os.platform() === 'win32' ? 'cp936' : 'utf-8';
const binaryEncoding = 'binary';  // PowerShell 输出的编码

// 获取脚本路径和参数
const scriptPath = path.join(__dirname, 'crawl1.ps1');
const { argv } = require('node:process');
const url = argv.slice(2)[0];

if (!url) {
    console.error('请提供一个URL作为参数');
    process.exit(1);
}

const command = `powershell -ExecutionPolicy Bypass -File "${scriptPath}" ${url}`;

// 执行脚本并处理编码
exec(command, { encoding: binaryEncoding }, (error, stdout, stderr) => {
    if (error) {
        console.error('错误:', iconv.decode(Buffer.from(error.message, binaryEncoding), encoding));
        return;
    }

    if (stderr) {
        console.error('标准错误:', iconv.decode(Buffer.from(stderr, binaryEncoding), encoding));
        return;
    }

    // 转码输出并处理 HTML
    const decodedOutput = iconv.decode(Buffer.from(stdout, binaryEncoding), encoding);
    try {
        const dom = new JSDOM(decodedOutput);
        console.log(`网页标题: ${dom.window.document.title}`);
    } catch (err) {
        console.error('解析失败:', iconv.decode(Buffer.from(err.message, binaryEncoding), encoding));
    }
});
