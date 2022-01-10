const fs = require("fs").promises;
const puppeteer = require("puppeteer");

const docsHostName = process.env.DOCS_HOSTNAME || "our-hello-docs";
const docsPortNumber = process.env.DOCS_PORT || 8000;
const screenshotsPath = process.env.SCREENSHOTS_PATH || "/screenshots";

const captureScreenshot = async (url, screenshotImageFileName) => {
  console.log(`GET: ${url}`);

  await page.goto(url);

  console.log("Capturing a screenshot...");

  await page.screenshot({
    path: `${screenshotsPath}/${screenshotImageFileName}`,
  });

  console.log("Successfully captured a screenshot.");
};

(async () => {
  console.log("Launching puppeteer browser...");

  const browser = await puppeteer.launch({
    headless: true,
    args: [
      "--no-sandbox",
      "--disable-setuid-sandbox",
      "--disable-dev-shm-usage",
      "--single-process",
    ],
  });

  console.log("Successfully launched puppeteer browser.");

  console.log("Creating a new page...");

  const page = await browser.newPage();

  console.log("Successfully created a new page.");

  const baseUrl = `http://${docsHostName}:${docsPortNumber}/hello-cloud`;

  const screenshotConfigurations = [
    { url: baseUrl, image: "hello-cloud.png" },
    { url: `${baseUrl}/contribute/`, image: "contribute.png" },
  ];

  screenshotConfigurations.forEach(async (screenshotConfiguration) => {
    await captureScreenshot(
      screenshotConfiguration.url,
      screenshotConfiguration.image
    );
  });

  console.log("Closing the browser...");

  await browser.close();

  console.log("Successfully closed the browser.");
})();
