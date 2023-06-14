import { Controller } from "@hotwired/stimulus"
import {loadStripe} from '@stripe/stripe-js';


// Connects to data-controller="stripe"
export default class extends Controller {
  static values = {stripePublishableKey: String, sessionId: String}

  async connect() {
    console.log(this.stripePublishableKeyValue, this.sessionIdValue)
    this.stripe = await loadStripe(this.stripePublishableKeyValue);

    };

  checkout() {
    this.stripe.redirectToCheckout({
      sessionId: this.sessionIdValue

  })}
}



{/* <script src="https://js.stripe.com/v3/"></script>
<script>
  const paymentButton = document.getElementById('pay');
  paymentButton.addEventListener('click', () => {
    const stripe = Stripe('<%= ENV['STRIPE_PUBLISHABLE_KEY'] %>');
    stripe.redirectToCheckout({
      sessionId: '<%= current_user.lastest_stripe_session_id %>'
    });
  });
</script> */}
