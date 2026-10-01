<!-- Floating theme toggle -->
<button id="themeToggleBtn" class="theme-toggle-btn" title="Toggle light / dark mode">🌙</button>

<!-- Floating chatbot widget -->
<button id="chatbotBubble" class="chatbot-bubble" title="Chat with EduManage Assistant">💬</button>
<div id="chatbotPanel" class="chatbot-panel">
    <div class="chatbot-header">
        <div>EduManage Assistant<span class="sub">Ask about courses, admissions & more</span></div>
        <span id="chatbotClose" class="chatbot-close">&times;</span>
    </div>
    <div id="chatbotMessages" class="chatbot-messages">
        <div class="chat-msg bot">Hi! 👋 I'm the EduManage assistant. Ask me about courses, admissions, batches, fees, or anything else.</div>
    </div>
    <div id="chatbotQuick" class="chatbot-quick"></div>
    <div class="chatbot-input">
        <input id="chatbotInput" type="text" placeholder="Type a message...">
        <button id="chatbotSend">Send</button>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/theme.js"></script>
<script src="${pageContext.request.contextPath}/js/chatbot.js"></script>
