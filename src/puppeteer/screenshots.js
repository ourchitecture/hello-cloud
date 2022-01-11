const fs = require("fs").promises;
const puppeteer = require("puppeteer");

const docsHostName = process.env.DOCS_HOSTNAME || "our-hello-docs";
const docsPortNumber = process.env.DOCS_PORT || 8000;
const screenshotsPath = process.env.SCREENSHOTS_PATH || "/screenshots";

const captureScreenshot = async (page, url, screenshotImageFileName) => {
  console.log(`GET: ${url}`);

  await page.goto(url);

  console.log(`Capturing the screenshot as ${screenshotImageFileName}...`);

  await page.screenshot({
    path: `${screenshotsPath}/${screenshotImageFileName}`,
    type: "png",
    fullPage: true,
  });

  console.log("Successfully captured the screenshot.");
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
    {
      url: `${baseUrl}/`,
      image: "hello-cloud.png",
    },
    {
      url: `${baseUrl}/clouds/`,
      image: "clouds.png",
    },
    {
      url: `${baseUrl}/devops/`,
      image: "devops.png",
    },
    {
      url: `${baseUrl}/roadmap/`,
      image: "roadmap.png",
    },
    {
      url: `${baseUrl}/contribute/`,
      image: "contribute.png",
    },
    {
      url: `${baseUrl}/comments/`,
      image: "comments.png",
    },
    {
      url: `${baseUrl}/license/`,
      image: "license.png",
    },
    {
      url: `${baseUrl}/services/dotnet/`,
      image: "services-dotnet.png",
    },
    {
      url: `${baseUrl}/services/java-springboot/`,
      image: "services-java-springboot.png",
    },
    {
      url: `${baseUrl}/services/kotlin-springboot/`,
      image: "services-kotlin-springboot.png",
    },
    {
      url: `${baseUrl}/services/nodejs-expressjs/`,
      image: "services-nodejs-expressjs.png",
    },
  ];

  for (
    let screenshotIx = 0;
    screenshotIx < screenshotConfigurations.length;
    screenshotIx++
  ) {
    const screenshotConfiguration = screenshotConfigurations[screenshotIx];

    await captureScreenshot(
      page,
      screenshotConfiguration.url,
      screenshotConfiguration.image
    );
  }

  console.log("Closing the browser...");

  await browser.close();

  console.log("Successfully closed the browser.");
})();
