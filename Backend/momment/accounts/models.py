from django.db import models
from django.contrib.auth.models import BaseUserManager, AbstractBaseUser


class Account(BaseUserManager):
    
    def create_user(self, email, name, birth, digit, address, password=None):
        if not email:
            raise ValueError("User must have Value")
        user = self.model(
            email = self.normalize_email(email),
            name = name,
            digit = digit,
            birth = birth,
            address = address
        )
        user.set_password(password)
        user.save(using=self._db)

        return user

    def create_superuser(self, email, name, birth, digit, address, password):
        user = self.create_user(
            email = self.normalize_email(email),
            name = name,
            password = password,
            digit = digit,
            birth = birth,
            address = address
        )
        user.is_admin = True
        user.is_staff = True
        user.is_superuser = True
        user.save(using=self._db)

        return user

class User(AbstractBaseUser):
    email = models.EmailField(verbose_name='ID', max_length=60, unique=True, null=False, blank=False)
    name = models.CharField(max_length=20, null=False, blank=False)
    digit = models.CharField(max_length=11)
    birth = models.DateField(verbose_name="생년월일", null=True, blank=True)
    address = models.CharField(max_length=80)
    is_admin = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    create_at = models.DateTimeField(verbose_name='date joined', auto_now_add=True)
    last_login  = models.DateTimeField(verbose_name='last login', auto_now=True)

    objects = Account()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['name', 'digit', 'address', 'birth']

    def __str__(self):
        return self.email
    
    def has_perm(self, perm, obj=None):
        return self.is_admin

    def has_module_perms(self, app_label):
        return True

