<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Booking Confirmation</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>
  <style>
    body {
      background: url('./asset/906112.jpg') center/cover no-repeat fixed;
      color: white;
      text-shadow: 1px 1px 2px black;
      overflow-x: hidden;
    }
    .confirmation-box {
      background-color: rgba(0,0,0,0.6);
      padding: 40px;
      border-radius: 12px;
      max-width: 700px;
      margin: 80px auto;
      display: none;
    }
    .confirmation-box h1 {
      font-size: 2.5rem;
      margin-bottom: 30px;
    }
    .confirmation-box h5 {
      color: #ffc107;
    }
    .btn-home {
      margin-top: 20px;
    }
    .spinner-overlay {
      position: fixed;
      top: 0; left: 0; right: 0; bottom: 0;
      background: rgba(0,0,0,0.9);
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 9999;
    }
  </style>
</head>
<body onload="startSequence()">

<audio id="celebrationSound">
  <source src="https://assets.mixkit.co/sfx/preview/mixkit-crowd-party-cheering-460.wav" type="audio/wav">
</audio>

<!-- Loading Spinner -->
<div class="spinner-overlay" id="loader">
  <div class="spinner-border text-warning" style="width: 4rem; height: 4rem;" role="status"></div>
</div>

<!-- Confirmation Content -->
<div class="confirmation-box text-center" id="confirmationBox">
  <h1>Booking Confirmed!</h1>
  <h5>Thank you <%= request.getAttribute("name") %>, your event has been booked successfully.</h5>
  <hr class="bg-light">

  <div class="row text-start mt-4">
    <div class="col-md-6">
      <p><strong>Occasion:</strong> <%= request.getAttribute("occasion") %></p>
      <p><strong>Date:</strong> <%= request.getAttribute("date") %></p>
      <p><strong>Duration:</strong> <%= request.getAttribute("hours") %></p>
    </div>
    <div class="col-md-6">
      <p><strong>Phone:</strong> <%= request.getAttribute("phone") %></p>
      <p><strong>Age:</strong> <%= request.getAttribute("age") %></p>
      <p><strong>Total Bill:</strong> <%= request.getAttribute("Totalbill") %></p>
    </div>
  </div>

  <a href="home.html" class="btn btn-warning btn-home me-2">Go to Home</a>
  <a id="whatsappBtn" target="_blank" class="btn btn-success btn-home">Share on WhatsApp</a>
</div>

<!-- JavaScript -->
<script>
  function startSequence() {
    setTimeout(() => {
      document.getElementById('loader').style.display = 'none';
      document.getElementById('confirmationBox').style.display = 'block';
      document.getElementById('celebrationSound').play();
      fireConfetti();
      buildWhatsAppMessage();
    }, 2000);
  }

  function fireConfetti() {
    const end = Date.now() + 3 * 1000;
    const colors = ['#bb0000', '#ffffff', '#FFD700', '#00ff00'];

    (function frame() {
      confetti({
        particleCount: 4,
        angle: 60,
        spread: 70,
        origin: { x: 0 },
        colors: colors
      });
      confetti({
        particleCount: 4,
        angle: 120,
        spread: 70,
        origin: { x: 1 },
        colors: colors
      });
      if (Date.now() < end) requestAnimationFrame(frame);
    })();
  }

  function buildWhatsAppMessage() {
    const name = `<%= request.getAttribute("name") %>`;
    const occasion = `<%= request.getAttribute("occasion") %>`;
    const date = `<%= request.getAttribute("date") %>`;
    const phone = `<%= request.getAttribute("phone") %>`;
    const hours = `<%= request.getAttribute("hours") %>`;
    const bill = `<%= request.getAttribute("Totalbill") %>`;

    const message = `Hey! I just booked an event at Celebrations Land!\n\n Name: ${name}\n Occasion: ${occasion}\n Date: ${date}\n Duration: ${hours}\n Contact: ${phone}\n Bill:{bill}`;
    const whatsappUrl = "https://wa.me/?text=" + encodeURIComponent(message);

    document.getElementById("whatsappBtn").href = whatsappUrl;
  }
</script>

</body>
</html>
