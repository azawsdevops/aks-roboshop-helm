default:
	helm upgrade -i $(appName) . -f env-$(env)/$(appName).yaml

dev:
	git pull
	helm upgrade -i cart . -f env-dev/cart.yaml
	helm upgrade -i catalogue . -f env-dev/catalogue.yaml
	helm upgrade -i user . -f env-dev/user.yaml
	helm upgrade -i payment . -f env-dev/payment.yaml
	helm upgrade -i shipping . -f env-dev/shipping.yaml
	helm upgrade -i frontend . -f env-dev/frontend.yaml

dev-destroy:
	helm uninstall cart
	helm uninstall catalogue
	helm uninstall user
	helm uninstall payment
	helm uninstall shipping
	helm uninstall frontend