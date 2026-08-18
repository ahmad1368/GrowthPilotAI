/// Bundled placeholder page for [VisualModelingScreen] (Issue #220) — no
/// real Next.js/React Flow `/canvas-lite` app exists yet for this
/// WebView to load (see PR notes), so this demonstrates the
/// `FlutterBridge` round-trip (Web -> Flutter) without depending on any
/// external server.
const canvasPlaceholderHtml = '''
<!DOCTYPE html>
<html>
<body style="font-family: sans-serif; padding: 24px; background: #09090b; color: #fafafa;">
  <h3>Visual Modeling (Coming Soon)</h3>
  <p>The React Flow canvas at /canvas-lite is not deployed yet.</p>
  <button onclick="simulateDoubleClick()">Simulate node double-click</button>
  <script>
    function simulateDoubleClick() {
      FlutterBridge.postMessage(JSON.stringify({
        event: 'onNodeDoubleClick',
        payload: { nodeId: 'demo-node', label: 'Demo requirement' }
      }));
    }
  </script>
</body>
</html>
''';
