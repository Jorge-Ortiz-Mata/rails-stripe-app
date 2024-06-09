import { Controller } from "@hotwired/stimulus"
import { loadStripe } from "@stripe/stripe-js";

// Connects to data-controller="stripe"
export default class extends Controller {
  connect() {
    this.onMountStripe();
  }

  fetchStripeCredentials = async () => {
    const response = await fetch('/credentials/stripe');
    const data = await response.json();
    return { 
      publicKey: data.credentials.public_key, 
      secretKey: data.credentials.secret_key 
    };
  }

  onMountStripe = async () => {
    const paymentForm = document.getElementById('payment-method-form')
    const stripeCredentials = await this.fetchStripeCredentials(); 
    const stripe = await loadStripe(stripeCredentials.publicKey);
    const elements = stripe.elements();
    const cardElement = elements.create('card');
    cardElement.mount('#card-element');

    paymentForm.addEventListener('submit', async (e) => {
      e.preventDefault();
      const customerId = document.getElementById("customer-id").value;

      const { error, paymentMethod } = await stripe.createPaymentMethod({
        type: 'card',
        card: cardElement,
      });

      if(error) {
        console.log(error);
        return;
      }
  
      await fetch('/stripe/attach/payment/method', {
        method: 'POST',
        headers: { 
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({ 
          payment_method_id: paymentMethod.id,
          customer_id: customerId
        }),
      }).then(() => {
        window.location.href = `/customers/${customerId}`;
      }).catch(err => {
        console.log(err)
      });
    })
  }
}
