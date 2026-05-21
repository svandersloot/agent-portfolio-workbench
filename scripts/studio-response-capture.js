/*
Run this in DevTools Console on a ROVO Studio agent page.

It captures matching Studio GraphQL responses in memory only.
Important: a full browser refresh removes this Console hook.

After running this script, trigger Studio to fetch the agent again without
refreshing the browser tab. For example, use Studio's in-app navigation to
open a different agent and then return to the target agent, or switch between
Studio views if that causes the agent details to reload.

After the Console logs at least one captured Studio response, run:

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

  console.log(
    "Studio capture enabled. Do not browser-refresh; use Studio in-app navigation to reload the agent, then run copyStudioAgentCaptures()."
  );
})();
