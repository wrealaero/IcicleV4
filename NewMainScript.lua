const key = "YOUR_MANUAL_KEY";  // Replace with your manual key

// Display the key on the page
function displayKey() {
    const keyElement = document.getElementById("key");
    if (keyElement) {
        keyElement.innerText = key;
    } else {
        console.log("Error: Element with id 'key' not found.");
    }
}

// Copy key to clipboard
function copyKey() {
    const keyElement = document.getElementById("key");
    if (keyElement) {
        const range = document.createRange();
        range.selectNode(keyElement);
        window.getSelection().removeAllRanges();
        window.getSelection().addRange(range);
        document.execCommand("copy");
        alert("Key copied to clipboard!");
    } else {
        alert("Error: Key element not found.");
    }
}

// Call displayKey function when the page loads
window.onload = displayKey;
