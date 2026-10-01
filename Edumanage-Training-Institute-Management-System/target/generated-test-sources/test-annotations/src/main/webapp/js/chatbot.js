(function () {
  var ctx = window.EDUMANAGE_CONTEXT_PATH || '';

  var FAQ = [
    { keys: ['course', 'courses', 'programs', 'program'],
      answer: 'We offer Java Full Stack, Python & Data Science, Frontend Development, and Digital Marketing. Check the Courses page for full details!' },
    { keys: ['fee', 'fees', 'price', 'cost'],
      answer: 'Fees vary by course. Please share your phone number via the Contact page or the inquiry form and our team will reach out with pricing.' },
    { keys: ['admission', 'register', 'registration', 'enroll', 'apply', 'join'],
      answer: 'You can register from the "Register Now" button on our homepage. Once submitted, our admin team reviews it and shares your login details.' },
    { keys: ['batch', 'batches', 'schedule', 'timing'],
      answer: 'Batches run in small trainer-led groups. Once you register and are approved, admin will assign you to a batch and trainer.' },
    { keys: ['login', 'password', 'sign in'],
      answer: 'You can log in from the Login page using the username and password shared with you after registration approval.' },
    { keys: ['trainer', 'teacher', 'instructor'],
      answer: 'Our trainers are assigned per batch by admin, and you can see your trainer\'s name on your dashboard once assigned.' },
    { keys: ['task', 'assignment', 'homework'],
      answer: 'Trainers assign tasks per batch. You can view and submit tasks from "My Tasks" on your student dashboard.' },
    { keys: ['attendance'],
      answer: 'Your attendance is marked by your trainer and you can track it anytime under "My Attendance".' },
    { keys: ['contact', 'phone', 'email', 'address'],
      answer: 'You can reach us at info@edumanage.com or +91 98765 43210. Check the Contact page for more.' },
    { keys: ['hi', 'hello', 'hey'],
      answer: 'Hi there! 👋 Ask me about our courses, admissions, batches, or anything else about EduManage.' }
  ];

  var QUICK_REPLIES = ['Courses', 'Admission process', 'Fees', 'Contact info'];

  function findAnswer(text) {
    var lower = text.toLowerCase();
    for (var i = 0; i < FAQ.length; i++) {
      for (var j = 0; j < FAQ[i].keys.length; j++) {
        if (lower.indexOf(FAQ[i].keys[j]) !== -1) return FAQ[i].answer;
      }
    }
    return "I'm not totally sure about that yet, but you can reach our team via the Contact page and we'll help you out!";
  }

  function addMessage(container, text, cls) {
    var div = document.createElement('div');
    div.className = 'chat-msg ' + cls;
    div.textContent = text;
    container.appendChild(div);
    container.scrollTop = container.scrollHeight;
  }

  document.addEventListener('DOMContentLoaded', function () {
    var bubble = document.getElementById('chatbotBubble');
    var panel = document.getElementById('chatbotPanel');
    var closeBtn = document.getElementById('chatbotClose');
    var messages = document.getElementById('chatbotMessages');
    var input = document.getElementById('chatbotInput');
    var sendBtn = document.getElementById('chatbotSend');
    var quickWrap = document.getElementById('chatbotQuick');

    if (!bubble || !panel) return;

    bubble.addEventListener('click', function () {
      panel.classList.toggle('open');
    });
    if (closeBtn) closeBtn.addEventListener('click', function () { panel.classList.remove('open'); });

    QUICK_REPLIES.forEach(function (label) {
      var b = document.createElement('button');
      b.textContent = label;
      b.addEventListener('click', function () { handleUserMessage(label); });
      quickWrap.appendChild(b);
    });

    function handleUserMessage(text) {
      if (!text.trim()) return;
      addMessage(messages, text, 'user');
      input.value = '';
      setTimeout(function () {
        addMessage(messages, findAnswer(text), 'bot');
      }, 350);
    }

    sendBtn.addEventListener('click', function () { handleUserMessage(input.value); });
    input.addEventListener('keydown', function (e) {
      if (e.key === 'Enter') handleUserMessage(input.value);
    });
  });
})();
