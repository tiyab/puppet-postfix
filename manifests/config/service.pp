#
# define a service in master.cf file of postfix
#
# Parameters:
#  $type
#    Specify the service type. one of:
#    inet, unix, fifo, pass.
#    defaults to 'unix'
#  $command
#    The command to be executed.
#    defaults to $title
#  $args       
#    Array of commands arguments
#  $service_names
#    Array of service names to configure. 
#    defaults to [$title]
#  $priv
#    Whether or not access is restricted to the mail system.
#    defaults '-' (use built-in default)
#  $unpriv
#    Whether the service runs with root privileges or as 
#    the owner of the Postfix system.
#    defaults '-' (use built-in default)
#  $chroot
#    Whether or not the service runs chrooted to the mail
#    queue directory.
#    defaults '-' (use built-in default)
#  $wakeup
#    Wake up time
#    defaults 'n' (default for postfix >= 3.0)
#  $maxproc
#    The maximum number of processes that may execute
#    this service simultaneously
#    defaults 'n' (default for postfix >= 3.0)
#  $active
#    if false, the service will not be activated (commented out)
#    default: true,
#  $comments
#    Array of comments to print in front of the service definition.
#    defaults to [] (no comment)
#  $order
#    order of the fragment (defaults to '55')
#  $master_cf_file
#    target
#
# See master(5) for details
#
define postfix::config::service (
  String  $master_cf_file,
  String  $type           = 'unix',
  String  $command        = $title,
  Array   $service_names  = [ $title ],
  String  $priv           = '-',
  String  $unpriv         = '-',
  String  $chroot         = '-',
  String  $wakeup         = '-',
  String  $maxproc        = '-',
  Array   $args           = [],
  Array   $comments       = [],
  Boolean $active         = true,
  String  $order          = '55',
){

  concat::fragment{"master.cf service: ${title}":
    target  => $master_cf_file,
    content => template('postfix/service.erb'),
    order   => $order,
  }

}
