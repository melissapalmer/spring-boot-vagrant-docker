ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'
 
Vagrant.configure("2") do |config|
 
	config.vm.define "springboot-docker" do |m|	 
		m.vm.provision :shell, inline: "sudo apt-get update"

		m.vm.provider "docker" do |d|
			d.name = 'springboot-docker'
			
			d.force_host_vm = true
			d.has_ssh = true

			#this will look for a Dockerfile in the same directory as the Vagrantfile. 
			#When vagrant up --provider=docker is run, Vagrant automatically builds that Dockerfile and starts a container based on that Dockerfile
			
			d.build_dir = "." 
			d.ports = ["8080:8080"]
			d.remains_running = true
			
			d.vagrant_machine = "springbootdockerhostvm"
			d.vagrant_vagrantfile = "./DockerHostVagrantfile"
		end
	end
end