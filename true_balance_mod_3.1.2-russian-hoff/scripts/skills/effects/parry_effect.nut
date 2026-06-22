this.parry_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
		Frame = 0,
		SkillCount = 0
	},
	function create()
	{
		this.m.ID = "effects.parry";
		this.m.Name = "Парирование";
		this.m.Description = "Боец готов парировать следующую атаку!";
		this.m.Icon = "ui/perks/feint_circle.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local fat = 0;
		local body = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local off = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (body != null)
		{
			fat = fat + body.getStaminaModifier();
		}

		if (head != null)
		{
			fat = fat + head.getStaminaModifier();
		}

		if (off != null)
		{
			fat = fat + off.getStaminaModifier();
		}

		local actor = this.getContainer().getActor();
		local mel = this.Math.max(0, ((this.getContainer().getActor().getBaseProperties().getRangedDefense() + this.Math.floor(this.getContainer().getActor().getInitiative() * 0.6) + fat)));
		local mels = this.Math.minf(95, mel);
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "Шанс парировать первую атаку в ближнем бою составляет [color=" + this.Const.UI.Color.PositiveValue + "]" + mels + "%[/color]"
			}
		];
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}

		if (!this.isHidden())
		{
            local ht = this.Math.rand(1, 100);
			local actor = this.getContainer().getActor();
			local fat = 0;
			local body = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
			local head = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);
			local off = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

			if (body != null)
			{
				fat = fat + body.getStaminaModifier();
			}

			if (head != null)
			{
				fat = fat + head.getStaminaModifier();
			}

			if (off != null)
			{
				fat = fat + off.getStaminaModifier();
			}

			local mel = this.Math.max(0, ((this.getContainer().getActor().getBaseProperties().getRangedDefense() + this.Math.floor(this.getContainer().getActor().getInitiative() * 0.6) + fat)));

			if (mel < 95)
			{
				if (!this.isHidden() && !_skill.isRanged() && ht < mel && !actor.getSkills().hasSkill("effects.stunned") && !actor.getSkills().hasSkill("effects.sleeping"))
				{
					++this.m.Stacks;
					this.Sound.play("sounds/combat/impale_01.wav");
					this.spawnIcon("feint_circle", this.m.Container.getActor().getTile());
					_properties.DamageReceivedTotalMult *= 0.5;
					this.m.IsHidden = true;
				}
			}
            else
			{
				if (!this.isHidden() && !_skill.isRanged() && ht < mel && !actor.getSkills().hasSkill("effects.stunned") && !actor.getSkills().hasSkill("effects.sleeping"))
				{
					++this.m.Stacks;
					this.Sound.play("sounds/combat/impale_01.wav");
					this.spawnIcon("feint_circle", this.m.Container.getActor().getTile());
					_properties.DamageReceivedTotalMult *= 0.5;
					this.m.IsHidden = true;
				}
			}
		}
	}

	function onTurnStart()
	{
		this.m.IsHidden = false;
		this.m.Stacks = 0;
		this.m.Frame = 0;
		this.m.SkillCount = 0;
	}

	function onUpdate( _properties )
	{
		if (("State" in this.Tactical) && this.Tactical.State != null)
		{
			local items = this.getContainer().getActor().getItems();
			local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
			local actor = this.getContainer().getActor();

			if (off != null && off.getID() != "shield.buckler" && !off.isItemType(this.Const.Items.ItemType.Tool))
			{
				this.m.IsHidden = true;
			}
			else if (this.m.Stacks == 0)
			{	
				this.m.IsHidden = false;
			}
			
			if (actor.getSkills().hasSkill("effects.stunned"))
			{
				this.m.IsHidden = true;
			}
		}
		else
		{
			local items = this.getContainer().getActor().getItems();
			local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);

			if (off != null && off.getID() != "shield.buckler" && !off.isItemType(this.Const.Items.ItemType.Tool))
			{
				this.m.IsHidden = true;
			}
			else
			{	
				this.m.IsHidden = false;
			}
		}
	}

});

