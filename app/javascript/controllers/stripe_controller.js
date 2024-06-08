import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="stripe"
export default class extends Controller {
  connect() {
    this.fetchCredentials();
  }

  fetchCredentials = async () => {
    const response = await fetch('/credentials/stripe');
    const data = await response.json();
    const { public_key, secret_key } = data.credentials;
  }
}
