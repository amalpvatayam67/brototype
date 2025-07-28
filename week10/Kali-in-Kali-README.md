
# 🔐 Kali in Kali — VirtualBox Installation Guide

This guide walks you through the process of installing **Kali Linux inside Kali Linux** using **VirtualBox** — a perfect setup for creating a safe ethical hacking lab inside your main Kali system.

---

## 📥 Step 1: Download Kali Linux (VirtualBox Image)

Head to the official Kali downloads page:

👉 [Download Kali VirtualBox Image](https://www.kali.org/get-kali/#kali-virtual-machines)

Choose the **VirtualBox** option.

![Download Image](https://lh3.googleusercontent.com/drive-viewer/AITFw-zq-rk4Z7mLnHqtKZXscNjSP7CeLn3hpg0OB_4NyCn3yo08TrVopk3-N_ZxUHFZ6ymDsj_t3pY=w1920-h902)

---

## 🗜 Step 2: Extract the `.7z` Archive

Use the following command to extract:

```bash
sudo apt install p7zip-full
7z x kali-linux-*.7z
```

You’ll get two files:

- `.vbox` → VM settings
- `.vdi` → Virtual hard disk

![Extracted Files](https://lh3.googleusercontent.com/drive-viewer/AITFw-z5sXWSoL5axqNnRRcS1uT0-2zqK1r-ec-wVdR5qxEDw7bq-5unQXvFrtXgAk-1qsNjaDHoPcrU=w1920-h902)

---

## 🖥️ Step 3: Import the VM in VirtualBox

Open VirtualBox → Click **Machine > Add** → Select the `.vbox` file.

This will register the Kali guest VM.

---

## ❌ Common Error: Kernel Driver Not Installed (rc=-1908)

If you get this error when starting the VM:

![Kernel Driver Error](https://lh3.googleusercontent.com/drive-viewer/AITFw-w5NLaMRJALPTr7VjcWFiZGKrkR74sVXUvEzv-1rNuf9M1sI4CEpg7dckZTO1R8sRpYvwweUGA=w1920-h902)

---

## ✅ Fix: Install Supported Kernel and Headers

```bash
sudo apt install linux-image-6.12.33+kali-amd64 linux-headers-6.12.33+kali-amd64
sudo update-grub
sudo reboot
```

On reboot, select:
```
Advanced Options → Kali, with Linux 6.12.33+kali-amd64
```

Verify:
```bash
uname -r
```

Expected:
```
6.12.33+kali-amd64
```

---

## 🧰 Load VirtualBox Module

```bash
sudo apt install --reinstall virtualbox virtualbox-dkms
sudo modprobe vboxdrv
```

Then start VirtualBox again:

```bash
virtualbox
```

---

## 🎉 Success!

Your Kali-in-Kali lab is now up and running.

> Keep this setup isolated for testing tools, exploits, or CTF training — without affecting your host system.

---

### 🤝 Credits
Prepared with ❤️ by Amal  
📄 Based on step-by-step experimentation inside a real Kali Linux environment
