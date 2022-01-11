const fs = require("fs").promises;
const puppeteer = require("puppeteer");

const screenshotsPath = process.env.SCREENSHOTS_PATH || "/screenshots";

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

  console.log("Visiting the hello-cloud project website...");

  await page.goto("https://www.ourchitecture.io/hello-cloud/");

  console.log("Successfully visited the website.");

  console.log("Capturing a screenshot...");

  await page.screenshot({ path: `${screenshotsPath}/hello-cloud.png` });

  console.log("Successfully captured a screenshot.");

  console.log("Closing the browser...");

  await browser.close();

  console.log("Successfully closed the browser.");
})();
