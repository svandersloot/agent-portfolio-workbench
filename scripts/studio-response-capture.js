/*
Run this in DevTools Console on a ROVO Studio agent page.

It captures matching Studio GraphQL responses in memory only.
After refreshing the page, run:

  copyStudioAgentCaptures()

Then save the copied JSON to:

  data/raw/<agent-slug>.studio-response.json

Do not commit data/raw.
*/
(() => {
  const matches = [];
  const looksLikeStudioAgentResponse = (text) =>
    text.includes("agentStudio_agentById") ||
    text.includes("agentStudio_scenarioListByContainerId");

  if (!window.__studioAgentCaptureInstalled) {
    const originalFetch = window.fetch;
    window.fetch = async (...args) => {
      const response = await originalFetch(...args);
      const clone = response.clone();

      clone.text().then((text) => {
        if (!looksLikeStudioAgentResponse(text)) return;
        try {
          matches.push(JSON.parse(text));
          console.log("Captured Studio agent config response", matches.length);
        } catch {
          matches.push({ capturedAt: new Date().toISOString(), text });
          console.log("Captured matching non-JSON Studio response", matches.length);
        }
      }).catch(() => {});

      return response;
    };

    const originalOpen = XMLHttpRequest.prototype.open;
    const originalSend = XMLHttpRequest.prototype.send;

    XMLHttpRequest.prototype.open = function(method, url, ...rest) {
      this.__studioCaptureUrl = url;
      return originalOpen.call(this, method, url, ...rest);
    };

    XMLHttpRequest.prototype.send = function(...args) {
      this.addEventListener("load", function() {
        const text = this.responseText || "";
        if (!looksLikeStudioAgentResponse(text)) return;
        try {
          matches.push(JSON.parse(text));
          console.log("Captured Studio agent XHR response", matches.length);
        } catch {
          matches.push({
            capturedAt: new Date().toISOString(),
            url: this.__studioCaptureUrl,
            text
          });
          console.log("Captured matching non-JSON Studio XHR response", matches.length);
        }
      });
      return originalSend.apply(this, args);
    };

    window.__studioAgentCaptureInstalled = true;
  }

  window.__studioAgentCaptures = matches;
  window.copyStudioAgentCaptures = () => {
    copy(JSON.stringify(matches, null, 2));
    console.log(`Copied ${matches.length} captured Studio response(s).`);
  };

  console.log("Studio capture enabled. Refresh the agent page, then run copyStudioAgentCaptures().");
})();
