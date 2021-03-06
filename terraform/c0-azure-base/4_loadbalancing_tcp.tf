///////////////////////////////////////////////
//////// Pivotal Customer[0] //////////////////
//////// ALB for TCP routing //////////////////
///////////////////////////////////////////////

resource "azurerm_lb" "tcp" {
  name                = "${var.env_name}-tcp-lb"
  location            = "${var.location}"
  resource_group_name = "${var.env_name}"

  frontend_ip_configuration = {
    name                 = "frontendip"
    public_ip_address_id = "${var.pub_ip_id_tcp_lb}"
  }
}

resource "azurerm_lb_backend_address_pool" "tcp-backend-pool" {
  name                = "tcp-backend-pool"
  location            = "${var.location}"
  resource_group_name = "${var.env_name}"
  loadbalancer_id     = "${azurerm_lb.tcp.id}"
}

resource "azurerm_lb_probe" "tcp-probe" {
  name                = "tcp-probe"
  location            = "${var.location}"
  resource_group_name = "${var.env_name}"
  loadbalancer_id     = "${azurerm_lb.tcp.id}"
  protocol            = "TCP"
  port                = 80
}

resource "azurerm_lb_rule" "tcp-rule" {
  count               = 150
  name                = "tcp-rule-${count.index + 1024}"
  location            = "${var.location}"
  resource_group_name = "${var.env_name}"
  loadbalancer_id     = "${azurerm_lb.tcp.id}"

  frontend_ip_configuration_name = "frontendip"
  protocol                       = "TCP"
  frontend_port                  = "${count.index + 1024}"
  backend_port                   = "${count.index + 1024}"

  # Workaround until the backend_address_pool and probe resources output their own ids
  backend_address_pool_id = "${azurerm_lb.tcp.id}/backendAddressPools/${azurerm_lb_backend_address_pool.tcp-backend-pool.name}"
  probe_id                = "${azurerm_lb.tcp.id}/probes/${azurerm_lb_probe.tcp-probe.name}"
}
