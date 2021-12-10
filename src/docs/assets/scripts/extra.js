let promptAddToHomeScreen;

const spanAddToHomeScreen = document.getElementById('add-to-home-notification');
const btnAddToHomeScreen = document.getElementById('add-to-home');

window.addEventListener('beforeinstallprompt', (e) => {
  // Prevent Chrome 67 and earlier from automatically showing the prompt
  e.preventDefault();

  // Stash the event so it can be triggered later.
  promptAddToHomeScreen = e;

  // Update UI to notify the user they can add to home screen
  btnAddToHomeScreen.style.display = 'block';

  btnAddToHomeScreen.addEventListener('click', (e) => {

    // hide our user interface that shows our A2HS button
    spanAddToHomeScreen.style.display = 'none';

    // Show the prompt
    promptAddToHomeScreen.prompt();

    // Wait for the user to respond to the prompt
    promptAddToHomeScreen.userChoice.then((choiceResult) => {
        if (choiceResult.outcome === 'accepted') {
          spanAddToHomeScreen.innerHTML = 'This project has been added to your home screen!';
        }

        promptAddToHomeScreen = null;
      });
  });
});
